
import argparse
import os
from huggingface_hub import snapshot_download

default_model_dir = os.getcwd()
parser = argparse.ArgumentParser()
parser.add_argument('repo_route', help='HuggingFace仓库路径')
parser.add_argument('model_dir', nargs='?', default=default_model_dir, help='本地保存目录（可选）')
parser.add_argument('-proxy', '--proxy', default='', help='设置代理（可选）')

args = parser.parse_args()

if not args.repo_route:
    raise ValueError("必须提供HuggingFace仓库路径")
if args.proxy:
    os.environ["http_proxy"] = args.proxy
    os.environ["https_proxy"] = args.proxy
else:
    os.environ["http_proxy"] = ""
    os.environ["https_proxy"] = ""

snapshot_download(
    repo_id=args.repo_route,
    local_dir=args.model_dir,
    endpoint="https://hf-ach.pages.dev",
    local_dir_use_symlinks=False
)