ndd () {
   node -v >> /dev/null && node --inspect-brk $1
}
