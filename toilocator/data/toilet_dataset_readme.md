## **Dataset info**

### Useful columns

- district_name: the district that the toilet is at
- type: type of location the toilet is at
- toilet_name: the location of the toilet
- address: the address of the toilet
- image_link-href: the url link of the images of the toilet
- award: the number of stars in HTML format, number of "fa fa-star" means the number of stars of the review

## **Scraping process**

### Page

- <a href = "https://www.toilet.org.sg/loomapdirectory">toilet website</a>

### Web scraper: 

- [webscraper](https://webscraper.io)
- import the sitemap code 

### Sitemap code

```
{"_id":"toilet_row_by_row","startUrl":["https://www.toilet.org.sg/loomapdirectory"],"selectors":[{"id":"district","parentSelectors":["_root"],"type":"SelectorElementClick","clickElementSelector":".tabs li","clickElementUniquenessType":"uniqueText","clickType":"clickOnce","delay":2000,"discardInitialElements":"do-not-discard","multiple":true,"selector":".active div.tab__content"},{"id":"rows_in_table","parentSelectors":["district"],"type":"SelectorElement","selector":"tbody tr","multiple":true,"delay":0},{"id":"type","parentSelectors":["rows_in_table"],"type":"SelectorText","selector":"td:nth-of-type(1)","multiple":false,"delay":0,"regex":""},{"id":"image_link","parentSelectors":["rows_in_table"],"type":"SelectorLink","selector":"a","multiple":false,"delay":0},{"id":"award","parentSelectors":["rows_in_table"],"type":"SelectorHTML","selector":"td[nowrap]","multiple":false,"regex":"","delay":0},{"id":"address","parentSelectors":["rows_in_table"],"type":"SelectorText","selector":"td:nth-of-type(3)","multiple":false,"delay":0,"regex":""},{"id":"toilet_name","parentSelectors":["rows_in_table"],"type":"SelectorText","selector":"td:nth-of-type(2)","multiple":false,"delay":0,"regex":""},{"id":"district_name","parentSelectors":["district"],"type":"SelectorText","selector":"h2","multiple":false,"delay":0,"regex":""}]}
```