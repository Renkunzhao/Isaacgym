# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib

# uv
pip install uv
uv venv --python 3.8 --clear
source .venv/bin/activate

# IsaacGym
cd $PROJECT_DIR/python
uv pip install -e .

# IsaacGymEnvs
cd $PROJECT_DIR/lib
git clone https://github.com/isaac-sim/IsaacGymEnvs.git
cd IsaacGymEnvs
uv pip install -e .

uv pip install "numpy<1.24"
