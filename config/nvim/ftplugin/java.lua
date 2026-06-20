local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local path_to_lombok = jdtls_dir .. "/lombok.jar"
local config_dir = jdtls_dir .. "/config_linux"
local plugins_dir = jdtls_dir .. "/plugins/"
local path_to_jar = plugins_dir .. "org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar"
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-dir/" .. project_name
vim.fn.mkdir(workspace_dir, "p")

local bundles = {
	vim.fn.glob(
		"/home/ferrissushi/.java/debug/extension/server/com.microsoft.java.debug.plugin-0.53.2.jar",
		true
	),
}

local java_test_bundles = vim.split(
	vim.fn.glob(
		"/home/ferrissushi/.java/test/extension/server/com.microsoft.java.test.plugin-*.jar",
		true
	),
	"\n"
)

local excluded = {
	"com.microsoft.java.test.runner-jar-with-dependencies.jar",
	"jacocoagent.jar",
}

for _, java_test_jar in ipairs(java_test_bundles) do
	local fname = vim.fn.fnamemodify(java_test_jar, ":t")
	if not vim.tbl_contains(excluded, fname) then
		table.insert(bundles, java_test_jar)
	end
end

local config = {
	cmd = {
		"/usr/lib/jvm/java-21-openjdk/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. path_to_lombok,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		path_to_jar,
		"-configuration",
		config_dir,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			format = {
				settings = {
					url = vim.fn.expand("~/.config/nvim/java/eclipse-java-4spaces.xml"),
					profile = "EverythingExceptGooglJavaFormatter",
				},
			},
		},
	},
	init_options = {
		bundles = bundles,
	},
}



require("jdtls").setup_dap({ hotcodereplace = "auto" })
require("jdtls").start_or_attach(config)

local dap = require("dap")
dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Launch current file",
		mainClass = "${file}",
	},
}

