# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/lib

# IsaacGym
cd $PROJECT_DIR/python
pip install -e .

# IsaacGymEnvs
cd $PROJECT_DIR/lib
git clone https://github.com/isaac-sim/IsaacGymEnvs.git
cd IsaacGymEnvs
pip install -e .

pip uninstall -y opencv-python opencv-contrib-python opencv-python-headless
pip install opencv-python-headless==4.5.5.64

pip uninstall -y torchtext
pip install --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121