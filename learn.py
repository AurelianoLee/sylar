import re
from git import Repo

# 获取当前 Git 仓库
repo = Repo(".")

# 确保 master 分支存在
if "master" not in repo.heads:
    print("❌ master 分支不存在")
    exit(1)

# 获取 master 分支所有 commit（从旧到新）
commits = list(repo.iter_commits("master"))[::-1]  # 反转顺序：从旧到新

for idx, commit in enumerate(commits, start=1):
    # 原始提交信息（只取第一行）
    raw_msg = commit.message.strip().splitlines()[0]

    # 格式化 commit message（替换冒号、空格）
    safe_msg = re.sub(r"[:\s]+", "-", raw_msg)

    # 构造分支名
    branch_name = f"learn/{idx}-{safe_msg}"

    # 如果分支已存在，则跳过
    if branch_name in repo.heads:
        print(f"✅ 分支已存在: {branch_name}，跳过")
        continue

    # 创建分支
    repo.create_head(branch_name, commit)
    print(f"✅ 创建分支: {branch_name}")

print("\n🎉 所有分支已创建完毕！")
