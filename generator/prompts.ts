import {checkbox, input, select} from '@inquirer/prompts';
import {ENGINE_FLAGS, PoolIdentifier} from './types';
import {getAssets} from './common';

// VALIDATION
function isNumber(value: string) {
  return !isNaN(value as unknown as number);
}

function isNumberOrKeepCurrent(value: string) {
  if (value == ENGINE_FLAGS.KEEP_CURRENT || isNumber(value)) return true;
  return 'Must be number or KEEP_CURRENT';
}

// TRANSFORMS
function transformNumberToPercent(value: string) {
  if (value && !isNaN(Number(value))) {
    return value.replace(/(?=(\d{2}$)+(?!\d))/g, '.') + ' %';
  }
  return value;
}

// TRANSLATIONS
function translateJsPercentToSol(value: string, bpsToRay?: boolean) {
  if (value === ENGINE_FLAGS.KEEP_CURRENT) return `EngineFlags.KEEP_CURRENT`;
  if (bpsToRay) return `_bpsToRay(${value.replace(/(?=(\d{2}$))/g, '_')})`;
  return value.replace(/(?=(\d{2}$)+(?!\d))/g, '_');
}

// PROMPTS
interface GenericPrompt {
  message: string;
  disableKeepCurrent?: boolean;
}

export type BooleanSelectValues =
  | typeof ENGINE_FLAGS.KEEP_CURRENT
  | typeof ENGINE_FLAGS.ENABLED
  | typeof ENGINE_FLAGS.DISABLED;

export async function booleanSelect({message, disableKeepCurrent}: GenericPrompt) {
  return select({
    message,
    choices: [
      ...(disableKeepCurrent ? [] : [{value: ENGINE_FLAGS.KEEP_CURRENT}]),
      {value: ENGINE_FLAGS.ENABLED},
      {value: ENGINE_FLAGS.DISABLED},
    ],
  });
}

interface PercentInputPrompt extends GenericPrompt {
  toRay?: boolean;
}

export type PercentInputValues = typeof ENGINE_FLAGS.KEEP_CURRENT | string;

export async function percentInput({message, disableKeepCurrent, toRay}: PercentInputPrompt) {
  const value = await input({
    message,
    transformer: transformNumberToPercent,
    validate: disableKeepCurrent ? isNumber : isNumberOrKeepCurrent,
  });
  return translateJsPercentToSol(value, toRay);
}

interface AssetsSelectPrompt extends Omit<GenericPrompt, 'disableKeepCurrent'> {
  pool: PoolIdentifier;
}

export function assetsSelect({pool, message}: AssetsSelectPrompt) {
  return checkbox({
    message,
    choices: getAssets(pool).map((asset) => ({name: asset, value: asset})),
  });
}
