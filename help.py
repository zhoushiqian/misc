#!/usr/bin/python
'''%prog [options]
'''
import optparse
import sys

if __name__ == '__main__':
    print 'hi'
    opt_parser = optparse.OptionParser(usage = __doc__)
    opt_parser.add_option('-t', '--test', dest='test', help='fdfdfdf')
    (options, args) = opt_parser.parse_args()
    print options
    print args
    print sys.argv[1:]
