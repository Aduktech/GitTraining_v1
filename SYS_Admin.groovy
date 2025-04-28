// Get system properties
printIn system.getProperty('os.name')
printIn system.getProperty('java.version')

//Execute a system command
def process = 'ls -l'.Execute()
printIn process.text 

// Create a new user
def user ='newuser'.Execute()
user.waitFor()