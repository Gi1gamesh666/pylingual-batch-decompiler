#!/bin/zsh

# ================================
# PyLingual 批量反编译 .pyc 脚本
# 功能：递归查找 .pyc 文件，调用 PyLingual 反编译，
#      并保持原目录结构 + 原始文件名（自动将 decompiled_xxx.py → xxx.py）
# ✅ 最终效果：得到 initialise.py，而不是 decompiled_initialise.py
# ================================

# --------------------------
# 配置区域（请按需修改）
# --------------------------

# 📂 输入目录：包含 .pyc 文件的目录，比如编译后的 Python 字节码目录
INPUT_DIR=""

# 📂 输出目录：反编译出来的 .py 文件存放位置
OUTPUT_DIR=""

# --------------------------
# 检查输入目录是否存在
# --------------------------
if [ ! -d "$INPUT_DIR" ]; then
  echo "❌ 输入目录不存在: $INPUT_DIR"
  exit 1
fi

# --------------------------
# 创建输出目录（如果不存在）
# --------------------------
mkdir -p "$OUTPUT_DIR"

# --------------------------
# 批量反编译 .pyc 文件
# --------------------------
echo "🔍 开始批量反编译 .pyc 文件"
echo "   输入目录: $INPUT_DIR"
echo "   输出目录: $OUTPUT_DIR"
echo "--------------------------------------------------"

# 使用 find 命令递归查找所有 .pyc 文件
find "$INPUT_DIR" -type f -name "*.pyc" | while read -r PYC_FILE; do
  # 获取相对路径（去掉开头的 INPUT_DIR/）
  REL_PATH="${PYC_FILE#$INPUT_DIR/}"

  # 构造目标 .py 文件名（将 .pyc 替换为 .py）
  PY_FILE="${REL_PATH%.pyc}.py"

  # 完整的目标 .py 文件路径（你最终想要的文件！比如 initialise.py）
  PY_FILE_FULL="$OUTPUT_DIR/$PY_FILE"

  # 获取该 .py 文件的目录，并创建目录（如果不存在）
  PY_DIR=$(dirname "$PY_FILE_FULL")
  mkdir -p "$PY_DIR"

  # PyLingual 默认会把结果生成到目录下并命名为 decompiled_原文件名.py
  # 所以我们先传入一个目录作为 -o，不传文件名
  PY_TARGET_DIR="$PY_DIR"

  echo "🔧 反编译: $PYC_FILE"
  echo "     → 最终目标文件: $PY_FILE_FULL"

  # 调用 PyLingual，传入 .pyc 文件路径 和 输出目录（PyLingual 会生成 decompiled_*.py）
  if poetry run pylingual "$PYC_FILE" -o "$PY_TARGET_DIR"; then
    # ✅ PyLingual 成功执行后，找到它生成的 decompiled_文件
    DECOMPILED_FILE="$PY_TARGET_DIR/decompiled_$(basename "${REL_PATH%.pyc}").py"

    if [ -f "$DECOMPILED_FILE" ]; then
      # ✅ 存在 decompiled_xxx.py，现在重命名为目标文件名 xxx.py
      mv "$DECOMPILED_FILE" "$PY_FILE_FULL"
      echo "✅ 反编译成功: $PY_FILE_FULL （已重命名自 decompiled_...）"
    else
      echo "❌ 反编译后未找到生成的 decompiled 文件: $DECOMPILED_FILE"
    fi
  else
    echo "❌ 反编译失败: $PYC_FILE"
  fi

  echo "--------------------------------------------------"
done

echo "🎉 批量反编译完成！所有 .py 文件已保存至: $OUTPUT_DIR"
