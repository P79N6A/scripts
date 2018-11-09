const execa = require('execa');
const yParser = require('yargs-parser');
const { readFileSync } = require('fs');
const { join } = require('path');

const args = yParser(process.argv.slice(2));

(async () => {
  if (args.on) {
    await execa.shell(`networksetup -setwebproxystate Wi-Fi on`);
    await execa.shell(`networksetup -setwebproxy Wi-Fi 127.0.0.1 1087`);
    await execa.shell(`networksetup -setsecurewebproxystate Wi-Fi on`);
    await execa.shell(`networksetup -setsecurewebproxy Wi-Fi 127.0.0.1 1087`);
    await execa.shell(`networksetup -setsocksfirewallproxystate Wi-Fi on`);
    await execa.shell(`networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 12307`);
  }

  if (args.off) {
    await execa.shell(`networksetup -setwebproxystate Wi-Fi off`);
    await execa.shell(`networksetup -setsecurewebproxystate Wi-Fi off`);
    await execa.shell(`networksetup -setsocksfirewallproxystate Wi-Fi off`);
  }

  // Set bypass
  if (args.on || args.bypass) {
    const BYPASS_PATH = join(__dirname, 'dotfiles/bypass');
    const content = readFileSync(BYPASS_PATH, 'utf-8');
    const domains = content.split(', ');
    console.log(domains.join(', '));

    try {
      await execa.shell(`
networksetup -setproxybypassdomains Wi-Fi ${domains.join(' ')}
    `.trim());
    } catch (e) {
      console.log(e);
    }
  }
})();
