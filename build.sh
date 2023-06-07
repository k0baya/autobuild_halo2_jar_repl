rm -rf BUILD_BY_K0BAYA
git clone https://github.com/halo-dev/halo && mv -b halo/* . && mv -b halo/.[^.]* . && rm -rf halo && npm install -g pnpm 
otag=$(curl -s "https://api.github.com/repos/halo-dev/halo/releases/latest" | grep -o '"tag_name": ".*"' | sed 's/"tag_name": "//;s/"//')
tag=$(echo "$otag" | sed 's/^v//')
git checkout $otag
echo "Console building..."
echo "May take three to five minutes..."
nohup make -C console build >/dev/null 2>&1
sed -i "s/^version=.*/version=$tag/" gradle.properties
chmod +x gradlew
echo "Fat Jar building..."
echo "May take one to three minutes..."
nohup ./gradlew clean build -x check >/dev/null 2>&1
mkdir -p BUILD_BY_K0BAYA
cp application/build/libs/* BUILD_BY_K0BAYA/halo_${tag}.jar
sleep 30
echo "Done！Now you can get the Jar file in the BUILD_BY_K0BAYA dir."
nohup find . ! -path "./BUILD_BY_K0BAYA*" ! -name "BUILD_BY_K0BAYA" ! -name "*.sh" ! -name "index.js" ! -name ".replit" ! -name ".config" ! -name "replit.nix" -exec rm -rf {} +  >/dev/null 2>&1
