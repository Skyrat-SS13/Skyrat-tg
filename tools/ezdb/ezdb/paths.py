import pathlib

def get_root_path():
    current_path = pathlib.Path(__file__)
    while current_path.name != 'tools':
        current_path = current_path.parent
    return current_path.parent

def get_config_path():
    return get_root_path() / 'config' / 'ezdb.txt'

def get_db_path():
    return get_root_path() / 'db'

def get_data_path():
    return get_db_path() / 'data'

def get_mariadb_bin_path():
    return get_db_path() / 'bin'

def get_mariadb_client_path():
    return get_mariadb_bin_path() / 'mariadb.exe'

def get_mariadb_daemon_path():
    return get_mariadb_bin_path() / 'mariadbd.exe'

def get_mariadb_install_db_path():
    return get_mariadb_bin_path() / 'mariadb-install-db.exe'

def get_initial_schema_path():
    return get_root_path() / 'SQL' / 'tgstation_schema.sql'

<<<<<<< HEAD
def get_modular_schema_path():
    return get_root_path() / 'SQL' / 'skyrat_schema.sql'

=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
def get_changelog_path():
    return get_root_path() / 'SQL' / 'database_changelog.md'
