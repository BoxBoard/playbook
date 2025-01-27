/* @flow */

import React from 'react'
import classnames from 'classnames'

import DateTime from '../pb_kit/dateTime'
import { buildCss } from '../utilities/props'
import { globalProps } from '../utilities/globalProps'

import Body from '../pb_body/_body'
import Title from '../pb_title/_title'

type DateYearStackedProps = {
  align?: "left" | "center" | "right",
  className?: string | array<string>,
  dark?: boolean,
  data?: string,
  date: string,
  id?: string,
}

const DateYearStacked = (props: DateYearStackedProps) => {
  const { align = 'left', className, dark = false, date } = props
  const dateTimestamp = new DateTime({ value: date })
  const css = classnames(
    buildCss('pb_date_year_stacked', align),
    globalProps(props),
    className
  )

  return (
    <div className={css}>
      <Title
          dark={dark}
          size={4}
          text={`${dateTimestamp.toDay()} ${dateTimestamp
          .toMonth()
          .toUpperCase()}`}
      />
      <Body color="light">{dateTimestamp.toYear()}</Body>
    </div>
  )
}

export default DateYearStacked
