#
# Copyright (c) 2015-2021 "Neo Technology,"
# Network Engine for Objects in Lund AB [http://neotechnology.com]
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Attribution Notice under the terms of the Apache License 2.0
#
# This work was created by the collective efforts of the openCypher community.
# Without limiting the terms of Section 6, any Derivative Work that is not
# approved by the public consensus process of the openCypher Implementers Group
# should not be described as “Cypher” (and Cypher® is a registered trademark of
# Neo4j Inc.) or as "openCypher". Extensions by implementers or prototypes or
# proposals for change that have been documented or implemented should only be
# described as "implementation extensions to Cypher" or as "proposed changes to
# Cypher that are not yet approved by the openCypher community".
#

#encoding: utf-8

Feature: Mathematical4 - Multiplication

  Scenario Outline: [1] Multiplication by zero
    When executing query:
      """
      RETURN <lhs> * <rhs> as result
      """
    Then the result should be, in any order:
    | result     |
    | <expected> |

    Examples:
      | lhs | rhs | expected |
      | 0   | 0   | 0        |
      | -1  | 0   | 0        |
      | -1  | 0   | 0        |
      | 0   | -1  | 0        |
      | 1   | 0   | 0        |
      | 0   | 1   | 0        |

  Scenario Outline: [2] Multiplication by rotation
    When executing query:
      """
      RETURN <lhs> * <rhs> as result
      """
    Then the result should be, in any order:
      | result     |
      | <expected> |

    Examples:
      | lhs | rhs | expected |
      | -1  | -1  | 1        |
      | -1  | 1   | -1       |
      | 1   | -1  | -1       |
      | 1   | 1   | 1        |

  Scenario Outline: [3] Multiplication by large numbers
    When executing query:
      """
      RETURN <lhs> * <rhs> as result
      """
    Then the result should be, in any order:
      | result     |
      | <expected> |

    Examples:
      | lhs                 | rhs         | expected             |
      | -4294967296         | 2147483648  | -9223372036854775808 |
      | 4611686018427387903 | 2           | 9223372036854775806  |

  Scenario Outline: [4] Fail when product exceeds maximum / minimum integer
    When executing query:
      """
      RETURN <lhs> * <rhs>
      """
    Then a SyntaxError should be raised at runtime: *

    Examples:
      | lhs         | rhs         |
      | 4294967296  | 2147483648  |
      | -4294967296 | 2147483649  |

  Scenario Outline: [5] Multiplication by mixed types
    When executing query:
      """
      RETURN <lhs> * <rhs> as result
      """
    Then the result should be, in any order:
      | result     |
      | <expected> |

    Examples:
      | lhs     | rhs   | expected  |
      | 1024    | 2     | 2048      |
      | 1024    | 2.0   | 2048.0    |
      | 1024    | 2e0   | 2048.0    |
      | 1024    | 0x2   | 2048      |
      | 1024    | 0o2   | 2048      |
      | 1024.0  | 2.0   | 2048.0    |
      | 1024.0  | 2e0   | 2048.0    |
      | 1024.0  | 0x2   | 2048.0    |
      | 1024.0  | 0o2   | 2048.0    |
      | 1.024e3 | 2e0   | 2048.0    |
      | 1.024e3 | 0x2   | 2048.0    |
      | 1.024e3 | 0o2   | 2048.0    |
      | 0x400   | 0x2   | 2048      |
      | 0x400   | 0o2   | 2048      |
      | 0o2000  | 0o2   | 2048      |

  Scenario Outline: [6] Multiplication with invalid types
    When executing query:
      """
      RETURN <lhs> * <rhs>
      """
    Then a SyntaxError should be raised at compile time: InvalidArgumentType

    Examples:
      | lhs | rhs     |
      | 1   | 'abc'   |
      | 1   | false   |
      | 1   | [1]     |
      | 1   | {}      |

  Scenario Outline: [7] Multiplication with null
    When executing query:
      """
      RETURN <lhs> * <rhs> as result
      """
    Then the result should be, in any order:
      | result     |
      | <expected> |

    Examples:
      | lhs     | rhs   | expected  |
      | 1       | null  | null      |
      | null    | 1     | null      |
      | null    | null  | null      |
