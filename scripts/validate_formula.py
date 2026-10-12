import json
from pathlib import Path
import re
import subprocess
import sys

def main():
    formula_path = Path("Formula/harness.rb")
    if not formula_path.exists():
        sys.exit("Formula/harness.rb not found")
        
    content = formula_path.read_text(encoding="utf-8")
    m_version = re.search(r'version "([^"]+)"', content)
    if not m_version:
        sys.exit("Version not found in Formula/harness.rb")
    version = m_version.group(1)

    shas = dict(re.findall(r'url ".*?/(harness_.*?)".*?sha256 "([a-f0-9]+)"', content, re.DOTALL))
    print(f"Formula references {len(shas)} assets for v{version}:")
    for asset, sha in shas.items():
        print(f"  {asset}: {sha}")

    out = subprocess.check_output(
        ["gh", "release", "view", f"v{version}", "-R", "Koality-Assured/harness-cli", "--json", "assets"],
        text=True
    )
    assets_data = json.loads(out).get("assets", [])
    release_assets = {a["name"]: a["digest"].replace("sha256:", "") for a in assets_data if a.get("digest")}

    for raw_asset, sha in shas.items():
        asset = raw_asset.replace("#{version}", version)
        expected = release_assets.get(asset)
        if not expected:
            sys.exit(f"Asset {asset} not found in release v{version}")
        if sha != expected:
            sys.exit(f"Checksum mismatch for {asset}: formula has {sha}, release has {expected}")
            
    print("All Formula checksums verified successfully against official release assets.")

if __name__ == "__main__":
    main()
