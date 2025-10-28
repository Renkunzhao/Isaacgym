# Get the project directory
PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"/../
mkdir -p $PROJECT_DIR/src

# Mimickit
cd $PROJECT_DIR/src
git clone https://github.com/xbpeng/MimicKit.git
cd MimicKit
uv pip install -r requirements.txt

wget -nc https://github.com/Renkunzhao/MimicKit/releases/download/Data/MimicKit_Data.zip
unzip -o MimicKit_Data.zip 'MimicKit_Data/*' -d data
rsync -a data/MimicKit_Data/* data/
rm -rf data/MimicKit_Data
