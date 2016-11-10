class asennus{

	Package { ensure => 'installed', allowcdrom => "true" }
		package { 'apache2':}
		package { 'gedit':}
		package { 'vlc':}
		package { 'pinta':}
		package { 'tree':}
		package { 'darktable':}
		package { 'rawtherapee':}

	file{"/var/www/html/index.html":
		content => "Hello world!\n",
	}

	file{"/home/xubuntu/public_html/index.html":
		content => template("asennus/asennus.erb")

	}

	file{"/etc/apache2/mods-enabled/userdir.conf":
		ensure => "link",
		target => "../mods-available/userdir.conf",
		notify => Service["apache2"],
	}

	file{"/etc/apache2/mods-enabled/userdir.load":
		ensure => 'link',
		target => '../mods-available/userdir.load',
		notify => Service["apache2"],
	}

	service {"apache2":
		ensure => "true",
		enable => "true",
	}
}

