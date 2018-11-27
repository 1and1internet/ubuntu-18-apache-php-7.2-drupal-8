#!/usr/bin/env python3

import unittest
from testpack_helper_library.unittests.dockertests import Test1and1Common
import time


class Test1and1Image(Test1and1Common):
    # <tests to run>

    def test_docker_logs(self):
        time.sleep(5)
        expected_log_lines = [
            "changed state to",
            "Executing hook /hooks/supervisord-pre.d/40_drupal_setup"
        ]
        container_logs = self.container.logs().decode('utf-8')
        for expected_log_line in expected_log_lines:
            self.assertTrue(
                container_logs.find(expected_log_line) > -1,
                msg="Docker log line missing: %s from (%s)" % (expected_log_line, container_logs)
            )

    def test_drupal(self):
        time.sleep(5)
        driver = self.getChromeDriver()
        driver.get("http://%s:8080/" % (Test1and1Image.container_ip))
        self.assertTrue(
            driver.title.find('Choose language') > -1,
            msg="Failed to find installation page"
        )

    # </tests to run>

if __name__ == '__main__':
    unittest.main(verbosity=1)
