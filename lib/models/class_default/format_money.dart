
import 'package:money_formatter/money_formatter.dart';

class FormatMoney{


static String formatMoney(double number)
{
MoneyFormatter fmf = MoneyFormatter(
    amount: number
);

return fmf.output.withoutFractionDigits;
}
//fmf.output.compactNonSymbol
static String formatM(double number)
{
MoneyFormatter fmf = MoneyFormatter(
    amount: number
);

return fmf.output.compactNonSymbol;
}

}