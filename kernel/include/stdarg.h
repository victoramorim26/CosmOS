#ifndef _STDARG_H_
#define _STDARG_H_

void va_start(va_list ap, last);
type va_arg(va_list ap, type);
void va_end(va_list ap);
void va_copy(va_list det, va_list src);

#endif
