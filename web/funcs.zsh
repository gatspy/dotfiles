ndd () {
   node -v >> /dev/null && node --inspect-brk $1
}
ndr () {
   node -v >> /dev/null && node $1
}
