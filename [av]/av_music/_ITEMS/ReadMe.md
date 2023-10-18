# For QBCore add this into shared/items.lua:
['cd'] = {['name'] = 'cd', ['label'] = 'CD', ['weight'] = 100, ['type'] = 'item', ['image'] = 'cd.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Support your local artist!'},

# OX_inventory
```
['cd'] = {
    label = 'CD',
    weight = 1,
    stack = false,
    close = true,
    description = 'Support your local artist!'
},
```

# For qs-core:
```
["cd"] = {
    ["name"] = "cd",
    ["label"] = "CD",
    ["weight"] = 2,
    ["type"] = "item",
    ["image"] = "cd.png",
    ["unique"] = true,
    ["useable"] = true,
    ["shouldClose"] = true,
    ["combinable"] = nil,
    ["description"] = ""
},
```

# qb-inventory description:

1) Go to qb-inventory/html/js/app.js
2) Search for ```function FormatItemInfo(itemData) {```
3) Add this:

```
else if (itemData.name == "cd") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html(
            "<p><strong>Artist: </strong><span>" +
            itemData.info.artist +
            "</span></p><p><strong>Song: </strong><span>" +
            itemData.info.song +
        "</p>"
    );
}
```

# Should look something like this: https://cdn.discordapp.com/attachments/1031816544495349830/1049385904013312111/image.png
