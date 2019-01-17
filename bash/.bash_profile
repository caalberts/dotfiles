alias ktopics='docker-compose exec kafka /opt/kafka_2.11-0.10.1.1/bin/kafka-topics.sh'
alias kconsole-producer='docker-compose exec kafka /opt/kafka_2.11-0.10.1.1/bin/kafka-console-producer.sh'
alias kconsole-consumer='docker-compose exec kafka /opt/kafka_2.11-0.10.1.1/bin/kafka-console-consumer.sh'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/albert/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/albert/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/albert/Downloads/google-cloud-sdk/completion.bash.inc'; fi

