# 📦 pylingual-batch-decompiler
Batch decompile .pyc Python bytecode files to .py source code using PyLingual, while preserving the original directory structure.

**pylingual-batch-decompiler** 是一个 **轻量级 Bash Shell 脚本工具**，用于 **批量反编译 Python 字节码文件（.pyc）为可读的 Python 源码文件（.py）**。

它专为集成和使用 PyLingual（一个基于 Poetry 的 Python 字节码反编译器）而设计，通过调用 `poetry run pylingual` 命令，实现对 `.pyc` 文件的批量反编译，并 **保持原有的目录结构**。

此外，PyLingual 默认会将反编译结果保存为 `decompiled_原文件名.py`，而本脚本会 **自动将这些文件重命名为原始的 `.py` 文件名**（如 `initialise.py`），让输出更加直观、整洁。



## 🛠️ 功能特性 | Features

|              功能              |
| :----------------------------: |
|    ✅ 批量反编译 `.pyc` 文件    |
|  ✅ 使用 PyLingual 反编译引擎   |
|        ✅ 保持原目录结构        |
| ✅ 自动重命名 `decompiled_*.py` |
|       ✅ 自动创建输出目录       |
|        ✅ 详细的日志输出        |
|    ✅ 适用于 Python 虚拟环境    |



## 📂 输入 / 输出 | Input & Output

- **🔒 输入目录（INPUT_DIR）**：包含多个 `.pyc` 文件的目录，通常是编译后的 Python 项目（如 Django、Flask 或其它字节码分发包）。
- **📤 输出目录（OUTPUT_DIR）**：反编译后生成的 `.py` 源码文件存放位置，结构与输入目录一致，文件为可读的 Python 源代码。

🔁 **转换示例：**

|  输入文件   |          输入路径示例           |  输出文件  |         输出路径示例          |
| :---------: | :-----------------------------: | :--------: | :---------------------------: |
| `.pyc` 文件 | `/project/src/utils/helper.pyc` | `.py` 文件 | `/output/src/utils/helper.py` |

> ⚠️ 注意：输出文件名不再是 `decompiled_helper.py`，而是干净的 `helper.py`（本脚本自动重命名）。



## 🚀 使用方法 | How to Use

### 1. 📥 准备环境

- 确保已安装：

  - Python 3.x
  - Poetry（PyLingual 依赖它）
  - PyLingual（已作为 Poetry 项目脚本安装，即支持 `poetry run pylingual`）

  - 最好使用venv环境

  ```bash
  git clone https://github.com/syssec-utd/pylingual
  cd pylingual
  python -m venv venv
  source venv/bin/activate
  pip install "poetry>=2.0"
  poetry install
  ```

​	   

### 2. 🛠️ 配置脚本

打开脚本 `auto-decompile.sh`（或你命名的主脚本文件），设置以下两个变量：

```bash
INPUT_DIR="/path/to/your/pyc_files"       # 存放 .pyc 文件的目录
OUTPUT_DIR="/path/to/output/py_files"     # 反编译后 .py 文件的输出目录
```

### 3. 🧪 运行脚本

确保脚本有执行权限：

```bash
chmod +x auto-decompile.sh
```

然后运行：

```bash
./auto-decompile.sh
```



## ✅ 输出效果 | Output Example

```markdown
输出目录/
└── utils/
    └── helper.py           # ✅ 原始文件名，不是 decompiled_helper.py
```

> 🎯 无需手动重命名，脚本自动完成！
