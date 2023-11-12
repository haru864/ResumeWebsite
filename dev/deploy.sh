#!/bin/bash -eEu

shopt -s inherit_errexit
on_error() {
    echo "[Err] ${BASH_SOURCE[1]}:${BASH_LINENO} - '${BASH_COMMAND}' failed">&2
}
trap on_error ERR

echo "Start Deployment"

# EC2インスタンスのユーザー名とアドレス
echo "EC2_PRIVATE_KEY: " && read EC2_PRIVATE_KEY
echo "EC2_USER: " && read EC2_USER
echo "EC2_ADDRESS: " && read EC2_ADDRESS
echo "GITHUB_SSH_KEY: " && read GITHUB_SSH_KEY

# リモートのGitリポジトリがあるディレクトリ
REMOTE_REPO_DIR="/home/ubuntu/recursion/ResumeWebsite"
DEPLOY_BRANCH="main"

# SSH接続とgit pullの実行
ssh -i $EC2_PRIVATE_KEY $EC2_USER@$EC2_ADDRESS << EOF
cd $REMOTE_REPO_DIR
git checkout $DEPLOY_BRANCH
GIT_SSH_COMMAND='ssh -i $GITHUB_SSH_KEY' git pull origin $DEPLOY_BRANCH
EOF

echo "Finish Deployment"
