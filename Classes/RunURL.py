#!/usr/bin/python
import requests
from requests import HTTPError


class RunURL:
    __timeout_connect = 180
    __timeout_process = 180
    __page_status = ''
    __page_url = ''
    __page_header = ''
    __page_content = ''
    __page_encoding = ''
    __page_elapsed = ''
    __page_history = ''

    def __init__(self):
        print('We handling the url connection!')

    def run_url(self, url):
        print('We want to run this url {} and get the complete page from the result!'.format(url))
        try:
            req = requests.get('https://' + url)
            req.raise_for_status()
        except HTTPError as http_err:
            print('HTTP error occurred: {}'.format(http_err))
            return http_err
        except Exception as err:
            print('Other error occurred: {}'.format(err))
            return err
        else:
            self.__page_encoding = req.encoding
            self.__page_elapsed = req.elapsed
            self.__page_history = req.history
            self.__page_url = req.url
            self.__page_status = req.status_code
            self.__page_header = req.headers
            self.__page_content = req.content

        return True

    def get_page_encoding(self):
        return self.__page_encoding

    def get_page_elapsed(self):
        return self.__page_elapsed

    def get_page_history(self):
        return self.__page_history

    def get_page_status(self):
        return self.__page_status

    def get_page_url(self):
        return self.__page_url

    def get_page_header(self):
        return self.__page_header

    def get_page_content(self):
        return self.__page_content
