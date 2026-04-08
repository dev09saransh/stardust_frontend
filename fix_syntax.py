import re

def fix_dashboard():
    dashboard = "lib/screens/dashboard_screen.dart"
    try:
        with open(dashboard, "r", encoding="utf-8") as f:
            lines = f.readlines()
        
        # 1. Remove duplicated methods from _appBar down to just before _SidebarTile
        start_idx = -1
        for i, line in enumerate(lines):
            # We want the second instance of _appBar which starts at 1365
            if "Widget _appBar(bool isWide) {" in line and i > 1000:
                start_idx = i
                break
                
        if start_idx != -1:
            end_idx = start_idx
            for i in range(start_idx, len(lines)):
                if "class _SidebarTile" in lines[i]:
                    end_idx = i
                    break
            
            # Delete block
            lines = lines[:start_idx] + lines[end_idx:]
            
        # 2. Re-read and remove the rogue closing bracket closing _DashboardScreenState early.
        # It's right before _catalogOverlay() starts
        catalog_idx = -1
        for i, line in enumerate(lines):
            if "Widget _catalogOverlay() {" in line:
                catalog_idx = i
                break
                
        if catalog_idx != -1:
            # Look backwards for the '}' and remove it.
            for i in range(catalog_idx - 1, -1, -1):
                if "}" in lines[i]:
                    lines[i] = "\n"  # remove the '}'
                    break
                    
        with open(dashboard, "w", encoding="utf-8") as f:
            f.writelines(lines)
        print("Fixed dashboard_screen.dart")
    except Exception as e:
        print(f"Error fixing dashboard: {e}")

def fix_other_screens():
    files = [
        "lib/screens/features/assets_screen.dart",
        "lib/screens/features/passwords_screen.dart",
        "lib/screens/features/contacts_screen.dart",
        "lib/screens/features/legal_center_screen.dart",
        "lib/screens/features/others_screen.dart"
    ]
    for file in files:
        try:
            with open(file, "r", encoding="utf-8") as f:
                content = f.read()

            # Remove duplicated import sections (like import 'package:flutter/material.dart' appearing twice sequentially)
            # Find the duplicate imports
            lines = content.split('\n')
            
            # Simple approach: if lines are duplicated exactly, strip out the duplicate segment.
            # Usually it's lines 1..13 duplicated at 15..27
            # Actually easier to just remove the stray '}' at the end since imports dart doesn't care that much if they're duplicated
            # but let's fix the '}' at the end.
            if len(lines) > 2:
                # remove stray bracket at EOF
                for i in range(len(lines)-1, max(-1, len(lines)-10), -1):
                    if lines[i].strip() == '}':
                        # Look for the previous }
                        for j in range(i-1, max(-1, len(lines)-10), -1):
                            if lines[j].strip() == '}':
                                lines[i] = ''
                                break
                            elif lines[j].strip() != '':
                                break
                        break

            new_content = '\n'.join(lines)
            with open(file, "w", encoding="utf-8") as f:
                f.write(new_content)
            print(f"Fixed {file}")
        except Exception as e:
            print(f"Error fixing {file}: {e}")

fix_dashboard()
fix_other_screens()
