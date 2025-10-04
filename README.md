<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-40README-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

# sento-cron - A library for scheduling periodic tasks using Sento actors framework.

<a id="sento-cron-asdf-system-details"></a>

## SENTO-CRON ASDF System Details

* Description: A library for scheduling periodic tasks using Sento actors framework.
* Licence: Unlicense
* Author: Alexander Artemenko <svetlyak.40wt@gmail.com>
* Homepage: [https://40ants.com/sento-cron/][b419]
* Bug tracker: [https://github.com/40ants/sento-cron/issues][6da4]
* Source control: [GIT][9b49]
* Depends on: [alexandria][8236], [cl-telegram-bot2][4426], [humanize-duration][9478], [local-time][46a1], [local-time-duration][6422], [log4cl-extras][691c], [sento][626d], [serapeum][c41d]

[![](https://github-actions.40ants.com/40ants/sento-cron/matrix.svg?only=ci.run-tests)][4dc6]

![](http://quickdocs.org/badge/sento-cron.svg)

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40INSTALLATION-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Installation

You can install this library from Quicklisp, but you want to receive updates quickly, then install it from Ultralisp.org:

```
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :sento-cron)
```
<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40USAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## Usage

`TODO`: Write a library description. Put some examples here.

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40API-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

## API

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40SENTO-CRON-2FSCHEDULE-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### SENTO-CRON/SCHEDULE

<a id="x-28-23A-28-2819-29-20BASE-CHAR-20-2E-20-22SENTO-CRON-2FSCHEDULE-22-29-20PACKAGE-29"></a>

#### [package](0ff5) `sento-cron/schedule`

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-7C-40SENTO-CRON-2FSCHEDULE-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40SENTO-CRON-2FSCHEDULE-24SCHEDULE-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### SCHEDULE

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASCHEDULE-20CLASS-29"></a>

###### [class](334a) `sento-cron/schedule:schedule` ()

**Readers**

<a id="x-28SENTO-CRON-2FSCHEDULE-3AEXTERNAL-SYSTEM-P-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FSCHEDULE-3ASCHEDULE-29-29"></a>

###### [reader](0168) `sento-cron/schedule:external-system-p` (schedule) (= nil)

If T, then actor system in slot `SYSTEM` was given to the function [`start-scheduler`][271b].

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASCHEDULE-SYSTEM-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FSCHEDULE-3ASCHEDULE-29-29"></a>

###### [reader](4c26) `sento-cron/schedule:schedule-system` (schedule) (= nil)

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASCHEDULE-TASKS-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FSCHEDULE-3ASCHEDULE-29-29"></a>

###### [reader](bbaa) `sento-cron/schedule:schedule-tasks` (schedule) (:tasks)

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASCHEDULER-IS-RUNNING-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FSCHEDULE-3ASCHEDULE-29-29"></a>

###### [reader](5d84) `sento-cron/schedule:scheduler-is-running` (schedule) (= nil)

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-7C-40SENTO-CRON-2FSCHEDULE-3FFunctions-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Functions

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASTART-SCHEDULER-20FUNCTION-29"></a>

##### [function](906b) `sento-cron/schedule:start-scheduler` schedule &key actor-system

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASTATUS-20FUNCTION-29"></a>

##### [function](62ec) `sento-cron/schedule:status` schedule

<a id="x-28SENTO-CRON-2FSCHEDULE-3ASTOP-SCHEDULER-20FUNCTION-29"></a>

##### [function](fc4d) `sento-cron/schedule:stop-scheduler` schedule &key (wait t)

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-7C-40SENTO-CRON-2FSCHEDULE-3FMacros-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Macros

<a id="x-28SENTO-CRON-2FSCHEDULE-3ADEFSCHEDULE-20-2840ANTS-DOC-2FLOCATIVES-3AMACRO-29-29"></a>

##### [macro](7156) `sento-cron/schedule:defschedule` var-name &body body

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40SENTO-CRON-2FTASK-3FPACKAGE-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

### SENTO-CRON/TASK

<a id="x-28-23A-28-2815-29-20BASE-CHAR-20-2E-20-22SENTO-CRON-2FTASK-22-29-20PACKAGE-29"></a>

#### [package](242a) `sento-cron/task`

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-7C-40SENTO-CRON-2FTASK-3FClasses-SECTION-7C-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

#### Classes

<a id="x-28SENTO-CRON-DOCS-2FINDEX-3A-3A-40SENTO-CRON-2FTASK-24TASK-3FCLASS-2040ANTS-DOC-2FLOCATIVES-3ASECTION-29"></a>

##### TASK

<a id="x-28SENTO-CRON-2FTASK-3ATASK-20CLASS-29"></a>

###### [class](dbe8) `sento-cron/task:task` ()

**Readers**

<a id="x-28SENTO-CRON-2FTASK-3ATASK-ACTOR-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FTASK-3ATASK-29-29"></a>

###### [reader](e561) `sento-cron/task:task-actor` (task) (= nil)

<a id="x-28SENTO-CRON-2FTASK-3ATASK-DELAY-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FTASK-3ATASK-29-29"></a>

###### [reader](96f0) `sento-cron/task:task-delay` (task) (:delay)

<a id="x-28SENTO-CRON-2FTASK-3ATASK-FUNC-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FTASK-3ATASK-29-29"></a>

###### [reader](31fd) `sento-cron/task:task-func` (task) (:func)

<a id="x-28SENTO-CRON-2FTASK-3ATASK-TIMER-20-2840ANTS-DOC-2FLOCATIVES-3AREADER-20SENTO-CRON-2FTASK-3ATASK-29-29"></a>

###### [reader](dc5b) `sento-cron/task:task-timer` (task) (= nil)


[b419]: https://40ants.com/sento-cron/
[271b]: https://40ants.com/sento-cron/#x-28SENTO-CRON-2FSCHEDULE-3ASTART-SCHEDULER-20FUNCTION-29
[9b49]: https://github.com/40ants/sento-cron
[4dc6]: https://github.com/40ants/sento-cron/actions
[0ff5]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L1
[906b]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L122
[7156]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L182
[62ec]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L220
[334a]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L40
[4c26]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L41
[0168]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L43
[bbaa]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L47
[5d84]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L50
[fc4d]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/schedule.lisp#L71
[242a]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L1
[dbe8]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L13
[96f0]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L14
[31fd]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L17
[dc5b]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L20
[e561]: https://github.com/40ants/sento-cron/blob/330b5e5a9a78f1ac737a39cfe249cb16f919cd1f/src/task.lisp#L23
[6da4]: https://github.com/40ants/sento-cron/issues
[8236]: https://quickdocs.org/alexandria
[4426]: https://quickdocs.org/cl-telegram-bot2
[9478]: https://quickdocs.org/humanize-duration
[46a1]: https://quickdocs.org/local-time
[6422]: https://quickdocs.org/local-time-duration
[691c]: https://quickdocs.org/log4cl-extras
[626d]: https://quickdocs.org/sento
[c41d]: https://quickdocs.org/serapeum

* * *
###### [generated by [40ANTS-DOC](https://40ants.com/doc/)]
