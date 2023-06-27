# sed

### ignore case
```
sed 's/old_value/new_value/i' file	
```

### replacing text
```
sed 's/old_value/new_value/' file	
```
's' replaces first occurence in every line.
's/old/new/g' - global, changes everywhere

Only show changed lines:
```
sed -n '/s/old/new/gp'
```

By default, 'old' is regex.
Use '&' to reference in 'new' matched part.

### not printing by default
```
sed -n # not auto print lines
```

### different delimiter
```
sed 's_com/pl_com/org_' 
```
### quotes
Can be both "" and ''

