#!/usr/bin/env python

import __main__ as main
if(__name__ == '__main__' and hasattr(main, '__file__')):

    ############################################################
    # Command line parsing.
    ############################################################

    import argparse
    import os
    import textwrap

    description = textwrap.dedent(
    """
    This script is used to ...
    """)

    epilog = textwrap.dedent(
    """
    Typical command line calls might look like:

    > python """ + os.path.basename(__file__) + """ -o file.out -np 1 <inputfilename>
    """ + u"\u2063")

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description=description, epilog=epilog)

    # Add required, positional, arguments.
    parser.add_argument(
        'inp', type = str,
        help = 'input file name')

    # Add required, named, arguments.
    required_named = parser.add_argument_group('required named arguments')
    required_named.add_argument(
        '--out', '-o', type = str, required = True,
        help = 'output file name')

    # Add optional, named, arguments.
    parser.add_argument(
        '--np', '-p', type = int, default = 1,
        help = 'number of processors to request (default: 1)')
    parser.add_argument(
        '--verbose', '-v', action='store_true',
        help = 'create verbose output, useful for debugging (default: false)')

    args = parser.parse_args()

    # Basic error checking of command line options.
    assert(os.path.isfile(args.inp)), 'Input file (' + args.inp + ') not found.'

    ############################################################
    # Program execution.
    ############################################################


