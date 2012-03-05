# Copyright (C) 2012 Olaf Lenz
#
# This file is part of ESPResSo.
#
# ESPResSo is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ESPResSo is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# This script generates the file doxyconfigure.h (used by doxygen)
#
import sys, featuredefs, time

if len(sys.argv) != 3:
    print >> sys.stderr, "Usage: %s DEFFILE HFILE" % sys.argv[0]
    exit(2)

deffilename, hfilename = sys.argv[1:3]

print "Reading definitions from " + deffilename + "..."
defs = featuredefs.defs(deffilename)
print "Done."

print "Writing " + hfilename + "..."
hfile = file(hfilename, 'w');

hfile.write("""/* 
WARNING: This file was autogenerated by

   %s on %s

   Do not modify it or your changes will be overwritten!
   Modify features.def instead.

  This file is needed so that doxygen will generate documentation for
  all functions of all features.
*/
#ifndef _DOXYCONFIG_H
#define _DOXYCONFIG_H

""" % (sys.argv[0], time.asctime()))

for feature in defs.features:
    hfile.write('#define ' + feature + '\n')

hfile.write("""
#endif /* of _DOXYCONFIG_H */""")
hfile.close()
print "Done."
