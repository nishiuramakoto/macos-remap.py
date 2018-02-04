#!/usr/bin/env python3

###############################################################################
# Please modify (or generalize) the following definitions to suit your needs  #
###############################################################################

# The lazy definition of remaps.
# remap_a_key(src, dst) defines the mapping from src to dst.
def remap():
    k = scan_codes()
    # Note: 'join' is the preferred name of the 'multiplication' of (so-called) monads.
    # The 'multiplication' of the list monad is the concatenation [[a]] -> [a].
    return join( [ remap_a_key(k['LeftControl'] , k['Eisu'] ),
                   remap_a_key(k['Eisu']        , k['LeftControl']),
                   remap_a_key(k['LeftCommand'] , k['LeftOption']),
                   remap_a_key(k['LeftOption']  , k['LeftCommand']),
                   remap_a_key(k['CapsLock']    , k['Kana']),
                   remap_a_key(k['Kana']        , k['RightControl']),
                   remap_a_key(k['RightCommand'], k['RightOption']),
                   remap_a_key(k['Yen']         , k['Tilde']),
                   remap_a_key(k['_']           , k['Esc'])
    ])

# See usbkeycode.md    
def scan_codes():
    return {
        'LeftControl' : 0xE0,
        'Eisu'        : 0x91,
        'LeftCommand' : 0xE3,
        'LeftOption'  : 0xE2,
        'CapsLock'    : 0x39,
        'Kana'        : 0x90,
        'RightCommand': 0xE7,
        'RightControl': 0xE4,
        'RightOption' : 0xE6,
        'Yen'         : 0x89,
        '_'           : 0x87,
        'Tilde'       : 0x35,
        'Esc'         : 0x29
    }

#########
# Code  #
#########

# https://apple.stackexchange.com/questions/283252/how-do-i-remap-a-key-in-macos-sierra-e-g-right-alt-to-right-control

import sys
import os
import itertools


# example usages of hidutil

# swap 'a' and 'b'
# hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000004,"HIDKeyboardModifierMappingDst":0x700000005},{"HIDKeyboardModifierMappingSrc":0x700000005,"HIDKeyboardModifierMappingDst":0x700000004}]}'

# dump current mapping
# hidutil property --get UserKeyMapping

# reset UserKeyMapping
# hidutil property --set '{"UserKeyMapping":[]}'


remap_JSON = '''
{
  "HIDKeyboardModifierMappingSrc":0x7000000%02x,
  "HIDKeyboardModifierMappingDst":0x7000000%02x
}
'''

def join(xss):
    return list(itertools.chain.from_iterable(xss)) 

def remap_a_key(src, dst) :
    if not isinstance(src, int) or src < 0:
        raise TypeError
    if not isinstance(dst, int) or dst < 0:
        raise TypeError

    return [remap_JSON % (src, dst)]

def swap_a_key(src, dst) :
    return join([remap_a_key(src, dst), remap_a_key(dst, src)])

def spawn(command):
    print(command)
    os.system(command)

def json_array(xs):
    return '[ %s ]' % ','.join(xs)

def remap_command(remap_def):
    array = json_array(remap_def)
    hash = '{"UserKeyMapping" : %s }' % array
    command = ''' hidutil property --set '%s'  ''' % hash
    return command
    
def check_reset_mode():
    try:
        return sys.argv[1] == "--reset"
    except:
        return False
    
if check_reset_mode():
    # reset UserKeyMapping
    command = ''' hidutil property --set '{"UserKeyMapping":[]}' '''
    spawn(command)

else:
    try:
        spawn(remap_command( remap() ))
        print('Successfully remapped')
    finally:
        print('Quitting')
    
