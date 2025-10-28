# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib

# Reference: 
# https://blog.csdn.net/m0_56706433/article/details/148902144
# https://developer.nvidia.com/cuda-12-8-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
# Install CUDA Toolkit 12.8 (if not already installed)
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
# dpkg -i cuda-keyring_1.1-1_all.deb
# apt-get update
# apt-get -y install cuda-toolkit-12-8

# Build PyTorch from source
cd $PROJECT_DIR/lib
git clone https://github.com/Renkunzhao/pytorch.git       # 1. 克隆主仓库
cd pytorch
git checkout torch2.3.1-cp38                    # 2. 切换到 v2.3.1 版本
git submodule update --init --recursive         # 3. 递归初始化子模块

export USE_CUDA=1
export TORCH_CUDA_ARCH_LIST="8.0;8.6;8.9;9.0;12.0"
export MAX_JOBS=$(nproc)
export USE_NUMPY=1

uv venv --python 3.8 --clear
source .venv/bin/activate

uv pip install numpy==1.23.5

python setup.py bdist_wheel