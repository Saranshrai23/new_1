pwd
mkdir -p linux/Assignment-01
mkdir /tmp/dir1
mkdir -p /tmp/dir1/{dir2,dir3}
rmdir /tmp/dir1/dir3

touch /tmp/Gourav
echo 'This is my first line' > /tmp/Gourav
echo 'this is a additional content' >> /tmp/Gourav

echo 'Sharma is my last name' > /tmp/Sharma

( echo 'this is line at the beginning' ; cat /tmp/Sharma ) > /tmp/Sharma.tmp && mv /tmp/Sharma.tmp /tmp/Sharma

cat >> /tmp/Sharma <<'EOF'
extra line 1
extra line 2
extra line 3
extra line 4
extra line 5
extra line 6
extra line 7
extra line 8
EOF

head -n 5 /tmp/Sharma
tail -n 2 /tmp/Sharma
head -n 6 /tmp/Sharma | tail -n 1
head -n 8 /tmp/Sharma | tail -n 6

ls -la /tmp
find /tmp -maxdepth 1 -type f -printf '%f\n'
find /tmp -maxdepth 1 -mindepth 1 -type d -printf '%f\n'

cp /tmp/Sharma /tmp/dir2/
cp /tmp/Sharma /tmp/dir2/Sharma.copy

mv /tmp/Gourav /tmp/Gourav-renamed

mv /tmp/Sharma /tmp/dir1/

> /tmp/dir2/Sharma.copy

rm /tmp/dir2/Sharma.copy
