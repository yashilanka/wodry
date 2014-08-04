##About

Wodry.js is a simple jQuery plugin for a text flipping/rotating. It was inspired by the Adjector.js. Wodry.js does the same things but it has new features that allow you to set animation from animations collection, set your own callback on content flipping, etc.

##How it works

You need to create html tag with content that will flip/rotate (like this):

```html

<div>
	Bla bla bla <span class="wodry">word1|word2|word3</span>
</div>

```

And in the script tag add this:

```javascript
$('.wodry').wodry();
```

##API Description