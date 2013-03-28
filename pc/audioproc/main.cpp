/*
 * main.cpp
 * 
 * Copyright 2013 Rick Jansen <rick@pholus>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 
 */




#include <iostream>
#include <string>
#include <boost/program_options.hpp>

using namespace std;

namespace po = boost::program_options;

int main(int argc, char **argv)
{
	po::options_description desc("Accepted Options");
	desc.add_options()
		("help", "produce help message")
		("output", po::value<int>(), "set output (0 = pipe, 1 = serial")
		("device", po::value<string>(), "depending on output type, the device to stream to")
	;

	po::variables_map vm;
	po::store(po::parse_command_line(argc, argv, desc), vm);
	po::notify(vm);    

	if (vm.count("help")) {
		cout << desc << "\n";
		return 1;
	}

	if (vm.count("output")) 
	{
		cout << "Selected output: ";
		if (vm["output"].as<int>() == 0)
		{
			cout << "pipe" << endl;
		}
		else if (vm["output"].as<int>() == 1)
		{
			cout << "serial" << endl;
		}
		else
		{
			cout << "[invalid value]. Exiting.." << endl;
			return 1;
		}
	} 
	else 
	{
		cout << "Output not selected. Exiting..." << endl;
		return 1;
	}
	
	
	
	return 0;
}

