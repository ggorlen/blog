# blog

ultra-minimal markdown blog

## installation

```
cpan Text::Markdown
```

## usage

```
perl generate.pl
```

This command takes all of the files with format `^\d{4}-\d\d-\d\d.*\.md$` in `/content` and generates HTML files in `/posts`. It also generates/overwites `index.html`. No existing posts are overwritten by default; use `rm posts/*` to clear the posts directory first. Each post must have a `# h1 title` of some sort.

You can adjust the CSS in `style.css` and the header and footer layouts in `/layouts`.
