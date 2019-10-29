.PHONY: all

all:
	docker build --progress=plain -t php5-fpm:latest .
