driftctl:
	driftctl scan --from "tfstate+s3://tyio-terraform/*.tfstate"

drift-ignore:
	driftctl scan --from "tfstate+s3://tyio-terraform/*.tfstate" -o json://stdout | driftctl gen-driftignore