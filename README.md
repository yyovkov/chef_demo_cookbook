# chef_demo_cookbook

## Create recipe
```bash
$ chef generate cookbook chef_demo_cookbook
```

## Create 'encryption' data bag
```bash
$ cd chef_demo_cookbook/test
$ knife data bag create encryption -z
$ tee data_bags/encryption/keys.json << 'EOF'
{
  "id": "keys",
  "filename": "/tmp/kitchen/data_bags/test_db_enc_key"
}
EOF
$ knife data bag from file encryption keys.json -z
```

## Generate encryption keys
```bash
$ openssl rand -base64 512 > data_bags/test_db_enc_key
```

### Generate sample rsa key pair
```bash
$ declare -a PRIVATE_KEY_
$ for env in $(echo _default env_test env_prod)
do
  ssh-keygen -t rsa -C "test@test.com" -N "" -q -f /tmp/${env}_rsa
  declare "PRIVATE_KEY_${env}=$(cat /tmp/${env}_rsa | sed 's/$/\\n/g'| tr -d '\r\n')"
done
```

## Create ssh-keys data bag
```bash
$ knife data bag create ssh_keys -z
$ tee data_bags/ssh_keys/user-a.json << EOF
{
  "id": "user-a",
  "_default":{
    "private_key": "${PRIVATE_KEY__default}"
  },
  "env_test":{
    "private_key": "${PRIVATE_KEY_env_test}"
  },
  "env_prod":{
    "private_key": "${PRIVATE_KEY_env_prod}"
  }
}
EOF
$ knife data bag from file ssh_keys user-a.json --secret-file data_bags/test_db_enc_key -z
```

# Update '.kitchen.yml'
Look at the '.kitchen.yml' file

# Update 'recipes/default.rb'
Look at the file
