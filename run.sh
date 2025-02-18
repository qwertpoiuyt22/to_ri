#!/bin/bash
set +x

echo "update ips"
rm -rf ru.txt
chmod +x update_target.sh
bash -c "./update_target.sh"

for TARGET in $(cat ru.txt); do
  sed -i 's/IP_TARGET/'${TARGET}'/g' .github/workflows/action.yml
  git checkout -b target_${TARGET}
  git add .; git commit -m "add"
  git push --set-upstream origin target_${TARGET}
  git checkout main; git pull
done
