
import { run } from 'uebersicht';

const updateWidget = (options) => {
  let config = [];
  Object.entries(options).forEach(([ key, val ]) => {
    config.push(`${key} ${typeof val === 'string' ? `"${val}"` : val}`);
  });
  config = config.join('\n');

  run(`echo '${config}' > ../configTemp.txt && sh UeberPlayer.widget/lib/updater.sh`)
    .catch(err => console.error(err));
}

export default updateWidget;
