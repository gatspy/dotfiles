mvn-create () {
    mvn archetype:generate -DgroupId=$1 -DartifactId=$2 -DarchetypeArtifactId=$3 -DinteractiveMode=false
}
