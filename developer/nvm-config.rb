require('../functions/add_variable')

zshrc = "#{ENV['HOME']}/.zshrc"

system("mkdir -p ~/.nvm")
add_variable(zshrc, ["NVM_DIR"],["$HOME/.nvm"])
#export NVM_DIR="$HOME/.nvm"
system(". /usr/local/opt/nvm/nvm.sh")
