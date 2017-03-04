/aB3/ {
	match($0, /href=\"[^\"]*\"/);
	url = substr($0, RSTART + 6, RLENGTH - 7);
	match($0, /target=\"_blank\">[^<]*<\/a>/);
	shop = substr($0, RSTART + 16, RLENGTH - 20);
	match($0, /<\/a><br>[^<]*<br>/);
	area = substr($0, RSTART + 8, RLENGTH - 12);
	if(length(shop) >= 1) {
		printf("%s\t%s\t%s\n", shop, area, url);
	}
}

