import subprocess
import argparse


def download_github_repo(repo_route, branch='main'):
    repo_route_hyphen = repo_route.replace('/', '-')
    url = f'https://api.github.com/repos/{repo_route}/zipball/{branch}'
    filename = f'{repo_route_hyphen}_{branch}.zip'

    try:
        cmd = ['curl', '-L', '-o', filename, url]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        print(f'下载成功{filename}')
    except subprocess.CalledProcessError as e:
        print(f'下载出错: {e.stderr}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='下载github项目分支为zip文件')
    parser.add_argument('repo_route', help='github项目')
    parser.add_argument('branch', nargs='?', default='main', help='下载的分支（默认main）')
    args = parser.parse_args()

    download_github_repo(args.repo_route, args.branch)