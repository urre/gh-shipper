# gh shipper

Simple deploy script for shipping stuff to Github pages. 

## Use

```bash
./deploy.sh
```

Or add as a npm script in ``package.json``.

```bash
"scripts": {
  "deploy": "./deploy.sh"
},
```

and then ``npm run deploy``

## Description

This is just a simple example of how you could do it. Tweak for yourself.

### Build

```bash
# Build project
npm run build
```

Build your project, in this example using a npm script called ``build``

```bash
# Stage files
git checkout master  
git add . 
```

Stage your files in git. Still on the master branch. Also just an example. Normally you should work on feature branches.

```bash
# Commit
read -p "Enter commit message: " desc
git commit -m "$desc" 
```

Type your commit message

```bash
# Bump version?
read -p "Bump version? (y/n): " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "\nCurrent git tag: "
    git describe --abbrev=0 --tags
    read -p "Enter new version (tag): " version
    
    # Using mversion as cross packaging module version bumper. https://github.com/mikaelbr/mversion
    mversion "$version" -m

    # Update npm package
    npm publish
fi
```

This chunk does the following:
+ Is this a new version?
+ If (y): 
1. Print current tag. 
2. let user type new version
3. Update version in package.json, bower.json, *.jquery.json etc using [mversion](https://github.com/mikaelbr/mversion)
4. Update the package on npm (remove if not using)

```bash
# Push to master
git push origin master --tags

# Keep gh-pages branch up to date with master
git checkout gh-pages
git merge master
git push origin gh-pages --tags
git checkout master
```

Push to master and keep ``gh-pages`` up to date with master. Done.