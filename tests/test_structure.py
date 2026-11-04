from pathlib import Path
import unittest
ROOT = Path(__file__).resolve().parents[1]
class TestStarterStructure(unittest.TestCase):
    def test_modules(self):
        for cloud in ('aws','azure','gcp'):
            for f in ('main.tf','variables.tf','outputs.tf','versions.tf','README.md'):
                self.assertTrue((ROOT/'terraform'/'modules'/cloud/'network'/f).is_file(), f'{cloud}/{f} missing')
    def test_dev_environments(self):
        for cloud in ('aws','azure','gcp'):
            for f in ('main.tf','variables.tf','versions.tf','terraform.tfvars.example'):
                self.assertTrue((ROOT/'terraform'/'environments'/'dev'/cloud/f).is_file())
if __name__ == '__main__': unittest.main()
