Spark Yaml Parser
===================

### This function will Parse a simple YAML file and will output concatenate --conf arguments

#### Typical Usage:
```
spark-shell $(sbin/parse-yaml.sh conf/spark-default.yml.template)
```
>- parse-yaml.sh: Yaml parser logic
>- spark-default.yml.template: Yaml file which contains spark configurations

#### Based on https://gist.github.com/pkuczynski/8665367