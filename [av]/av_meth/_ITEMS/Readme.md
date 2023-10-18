
# For qb-inventory go to html/js/app.js and add this inside FormatItemInfo function:
else if (itemData.name == "meth1g") {
    $(".item-info-title").html("<p>" + itemData.label + "</p>");
    $(".item-info-description").html(
        "<p><strong>Strain: </strong><span>" +
        itemData.info.strain +
        "</span></p><p><strong>Purity: </strong><span>" +
        itemData.info.purity +
        "</p>"
    );
}

# Should look something like this: 
https://cdn.discordapp.com/attachments/753595383757668403/1054449354980737164/image.png