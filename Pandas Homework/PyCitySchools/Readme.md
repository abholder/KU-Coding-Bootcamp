

```python
import pandas as pd

```


```python
# The path to our CSV file
students_file = "raw_data/students_complete.csv"
schools_file = "raw_data/schools_complete.csv"

```


```python
# Read our student data into pandas
students_df = pd.read_csv(students_file)

students_df.head()

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Student ID</th>
      <th>name</th>
      <th>gender</th>
      <th>grade</th>
      <th>school</th>
      <th>reading_score</th>
      <th>math_score</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Paul Bradley</td>
      <td>M</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>66</td>
      <td>79</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Victor Smith</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>94</td>
      <td>61</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Kevin Rodriguez</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>90</td>
      <td>60</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Dr. Richard Scott</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>67</td>
      <td>58</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Bonnie Ray</td>
      <td>F</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>97</td>
      <td>84</td>
    </tr>
  </tbody>
</table>
</div>




```python
# verify column names for student info
students_df.columns

```




    Index(['Student ID', 'name', 'gender', 'grade', 'school', 'reading_score',
           'math_score'],
          dtype='object')




```python
# Read our school data into pandas
schools_df = pd.read_csv(schools_file)

schools_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School ID</th>
      <th>name</th>
      <th>type</th>
      <th>size</th>
      <th>budget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Huang High School</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Figueroa High School</td>
      <td>District</td>
      <td>2949</td>
      <td>1884411</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Shelton High School</td>
      <td>Charter</td>
      <td>1761</td>
      <td>1056600</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Hernandez High School</td>
      <td>District</td>
      <td>4635</td>
      <td>3022020</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Griffin High School</td>
      <td>Charter</td>
      <td>1468</td>
      <td>917500</td>
    </tr>
  </tbody>
</table>
</div>




```python
# verify column names for school info
schools_df.columns

```




    Index(['School ID', 'name', 'type', 'size', 'budget'], dtype='object')




```python
# clean student table; prep for merging
# nothing for now, just looking at merging on school so the columns need to match
```


```python
#  clean school table; prep for merging
#  name column needs to be school, same as student table
renamed_schools_df = schools_df.rename(columns={"name":"school"})
renamed_schools_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>School ID</th>
      <th>school</th>
      <th>type</th>
      <th>size</th>
      <th>budget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Huang High School</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Figueroa High School</td>
      <td>District</td>
      <td>2949</td>
      <td>1884411</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Shelton High School</td>
      <td>Charter</td>
      <td>1761</td>
      <td>1056600</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Hernandez High School</td>
      <td>District</td>
      <td>4635</td>
      <td>3022020</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Griffin High School</td>
      <td>Charter</td>
      <td>1468</td>
      <td>917500</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Merge two dataframes using an outer join
students_schools_df = pd.merge(students_df, renamed_schools_df, on="school", how="outer")
students_schools_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Student ID</th>
      <th>name</th>
      <th>gender</th>
      <th>grade</th>
      <th>school</th>
      <th>reading_score</th>
      <th>math_score</th>
      <th>School ID</th>
      <th>type</th>
      <th>size</th>
      <th>budget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Paul Bradley</td>
      <td>M</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>66</td>
      <td>79</td>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Victor Smith</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>94</td>
      <td>61</td>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Kevin Rodriguez</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>90</td>
      <td>60</td>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Dr. Richard Scott</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>67</td>
      <td>58</td>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Bonnie Ray</td>
      <td>F</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>97</td>
      <td>84</td>
      <td>0</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
  </tbody>
</table>
</div>




```python
students_schools_df.columns
```




    Index(['Student ID', 'name', 'gender', 'grade', 'school', 'reading_score',
           'math_score', 'School ID', 'type', 'size', 'budget'],
          dtype='object')




```python
# the school ID is 0; clean it up
reduced_combined_df = students_schools_df[["Student ID", "name", "gender", "grade",
                       "school", "reading_score", "math_score", "type", "size", "budget"]]
reduced_combined_df.head()

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Student ID</th>
      <th>name</th>
      <th>gender</th>
      <th>grade</th>
      <th>school</th>
      <th>reading_score</th>
      <th>math_score</th>
      <th>type</th>
      <th>size</th>
      <th>budget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>0</td>
      <td>Paul Bradley</td>
      <td>M</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>66</td>
      <td>79</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1</td>
      <td>Victor Smith</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>94</td>
      <td>61</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2</td>
      <td>Kevin Rodriguez</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>90</td>
      <td>60</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3</td>
      <td>Dr. Richard Scott</td>
      <td>M</td>
      <td>12th</td>
      <td>Huang High School</td>
      <td>67</td>
      <td>58</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
    <tr>
      <th>4</th>
      <td>4</td>
      <td>Bonnie Ray</td>
      <td>F</td>
      <td>9th</td>
      <td>Huang High School</td>
      <td>97</td>
      <td>84</td>
      <td>District</td>
      <td>2917</td>
      <td>1910635</td>
    </tr>
  </tbody>
</table>
</div>




```python
# rename columns to make it easier to work with; we know we'll at least need this info to be presentable... can add more later
renamed_df = reduced_combined_df.rename(columns={"name": "Name",
                                        "gender": "Gender",
                                        "grade": "Grade",
                                        "school": "School",
                                        "reading_score": "Reading Score",
                                        "math_score": "Math Score",
                                        "type": "Type",
                                        "size": "Size",
                                        "budget": "Budget", })

renamed_df.tail()

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Student ID</th>
      <th>Name</th>
      <th>Gender</th>
      <th>Grade</th>
      <th>School</th>
      <th>Reading Score</th>
      <th>Math Score</th>
      <th>Type</th>
      <th>Size</th>
      <th>Budget</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>39165</th>
      <td>39165</td>
      <td>Donna Howard</td>
      <td>F</td>
      <td>12th</td>
      <td>Thomas High School</td>
      <td>99</td>
      <td>90</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
    </tr>
    <tr>
      <th>39166</th>
      <td>39166</td>
      <td>Dawn Bell</td>
      <td>F</td>
      <td>10th</td>
      <td>Thomas High School</td>
      <td>95</td>
      <td>70</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
    </tr>
    <tr>
      <th>39167</th>
      <td>39167</td>
      <td>Rebecca Tanner</td>
      <td>F</td>
      <td>9th</td>
      <td>Thomas High School</td>
      <td>73</td>
      <td>84</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
    </tr>
    <tr>
      <th>39168</th>
      <td>39168</td>
      <td>Desiree Kidd</td>
      <td>F</td>
      <td>10th</td>
      <td>Thomas High School</td>
      <td>99</td>
      <td>90</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
    </tr>
    <tr>
      <th>39169</th>
      <td>39169</td>
      <td>Carolyn Jackson</td>
      <td>F</td>
      <td>11th</td>
      <td>Thomas High School</td>
      <td>95</td>
      <td>75</td>
      <td>Charter</td>
      <td>1635</td>
      <td>1043130</td>
    </tr>
  </tbody>
</table>
</div>




```python
renamed_df.columns

```




    Index(['Student ID', 'Name', 'Gender', 'Grade', 'School', 'Reading Score',
           'Math Score', 'Type', 'Size', 'Budget'],
          dtype='object')




```python
# Converting the membership days into weeks and then adding a column to the DataFrame
# weeks = training_data["Membership (Days)"]/7
# training_data["Membership (Weeks)"] = weeks

# training_data.head()
```


```python
# district summary
# calculate total schools
# renamed_df["school_count"] = len(renamed_df["School"].unique())
school_count = len(renamed_df["School"].unique())
school_count
```




    15




```python
# calculate total students
# renamed_df["student_count"] = len(renamed_df["Student ID"].unique())
# renamed_df["student_count"] = renamed_df["Student ID"].count()
student_count = len(renamed_df["Student ID"].unique())
student_count
```




    39170




```python
# calculate total budget... directions don't say it, so assuming all schools are in same district and calculating a total budget for the entire district
school_budget = renamed_df.groupby('School')["Budget"].sum()
# renamed_df["total_budget"] = school_budget.sum()
school_budget
```




    School
    Bailey High School       15549641728
    Cabrera High School       2009159448
    Figueroa High School      5557128039
    Ford High School          4831365924
    Griffin High School       1346890000
    Hernandez High School    14007062700
    Holden High School         105933149
    Huang High School         5573322295
    Johnson High School      14733628650
    Pena High School           563595396
    Rodriguez High School    10186904637
    Shelton High School       1860672600
    Thomas High School        1705517550
    Wilson High School        3012587442
    Wright High School        1888920000
    Name: Budget, dtype: int64




```python
total_budget = school_budget.sum()
total_budget
```




    82932329558




```python
# avg math score
# renamed_df["average_math"] = renamed_df["Math Score"].mean()
# average_math
average_math = renamed_df["Math Score"].mean()
average_math
```




    78.98537145774827




```python
# avg reading score
# renamed_df["average_reading"] = renamed_df["Reading Score"].mean()
average_reading = renamed_df["Reading Score"].mean()
average_reading
```




    81.87784018381414




```python
# percent passing math; >70%
passing_math = renamed_df.loc[renamed_df["Math Score"] >= 70.0]
passing_math_count = passing_math.count()
# renamed_df["percent_passing_math"] = passing_math_count / student_count
# percent_passing_math
percent_passing_math = passing_math_count / student_count
percent_passing_math
```




    Student ID       0.749809
    Name             0.749809
    Gender           0.749809
    Grade            0.749809
    School           0.749809
    Reading Score    0.749809
    Math Score       0.749809
    Type             0.749809
    Size             0.749809
    Budget           0.749809
    dtype: float64




```python
# percent passing reading; >70%
passing_reading = renamed_df.loc[renamed_df["Reading Score"] >= 70.0]
passing_reading_count = passing_reading.count()
# renamed_df["percent_passing_reading"] = passing_reading_count / student_count
# percent_passing_reading
percent_passing_reading = passing_reading_count / student_count
percent_passing_reading
```




    Student ID       0.858055
    Name             0.858055
    Gender           0.858055
    Grade            0.858055
    School           0.858055
    Reading Score    0.858055
    Math Score       0.858055
    Type             0.858055
    Size             0.858055
    Budget           0.858055
    dtype: float64




```python
# overall passing rate; avg of percent passing math and percent passing reading
# renamed_df["overall_passing_avg"] = percent_passing_reading + percent_passing_math / 2
overall_passing_avg = (percent_passing_reading + percent_passing_math) / 2
overall_passing_avg
```




    Student ID       0.803932
    Name             0.803932
    Gender           0.803932
    Grade            0.803932
    School           0.803932
    Reading Score    0.803932
    Math Score       0.803932
    Type             0.803932
    Size             0.803932
    Budget           0.803932
    dtype: float64




```python
print(school_count)
print(student_count)
print(total_budget)
print(percent_passing_math)
print(percent_passing_reading)
print(overall_passing_avg)
```

    15
    39170
    82932329558
    Student ID       0.749809
    Name             0.749809
    Gender           0.749809
    Grade            0.749809
    School           0.749809
    Reading Score    0.749809
    Math Score       0.749809
    Type             0.749809
    Size             0.749809
    Budget           0.749809
    dtype: float64
    Student ID       0.858055
    Name             0.858055
    Gender           0.858055
    Grade            0.858055
    School           0.858055
    Reading Score    0.858055
    Math Score       0.858055
    Type             0.858055
    Size             0.858055
    Budget           0.858055
    dtype: float64
    Student ID       0.803932
    Name             0.803932
    Gender           0.803932
    Grade            0.803932
    School           0.803932
    Reading Score    0.803932
    Math Score       0.803932
    Type             0.803932
    Size             0.803932
    Budget           0.803932
    dtype: float64



```python


# summary table
summary_table = pd.DataFrame({"Total Schools": school_count,
                              "Total Students": student_count,
                              "Total Budget": school_budget,
                              "Percent Passing Math": percent_passing_math,
                              "Percent Passing Reading": percent_passing_reading,
                                "Overall Passing Rate": overall_passing_avg})

summary_table
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Overall Passing Rate</th>
      <th>Percent Passing Math</th>
      <th>Percent Passing Reading</th>
      <th>Total Budget</th>
      <th>Total Schools</th>
      <th>Total Students</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Bailey High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.554964e+10</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Budget</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Cabrera High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>2.009159e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Figueroa High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>5.557128e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Ford High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>4.831366e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Gender</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Grade</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Griffin High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.346890e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Hernandez High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.400706e+10</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Holden High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.059331e+08</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Huang High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>5.573322e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Johnson High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.473363e+10</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Math Score</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Name</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Pena High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>5.635954e+08</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Reading Score</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Rodriguez High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.018690e+10</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>School</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Shelton High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.860673e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Size</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Student ID</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Thomas High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.705518e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Type</th>
      <td>0.803932</td>
      <td>0.749809</td>
      <td>0.858055</td>
      <td>NaN</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Wilson High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>3.012587e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
    <tr>
      <th>Wright High School</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.888920e+09</td>
      <td>15</td>
      <td>39170</td>
    </tr>
  </tbody>
</table>
</div>




```python
# finding how many students at each school
students_per_school = renamed_df["School"].value_counts()
students_per_school


```




    Bailey High School       4976
    Johnson High School      4761
    Hernandez High School    4635
    Rodriguez High School    3999
    Figueroa High School     2949
    Huang High School        2917
    Ford High School         2739
    Wilson High School       2283
    Cabrera High School      1858
    Wright High School       1800
    Shelton High School      1761
    Thomas High School       1635
    Griffin High School      1468
    Pena High School          962
    Holden High School        427
    Name: School, dtype: int64




```python
# build school summary table
school_summary = students_per_school, total_budget, percent_passing_math, percent_passing_reading, overall_passing_avg
school_summary

```




    (Bailey High School       4976
     Johnson High School      4761
     Hernandez High School    4635
     Rodriguez High School    3999
     Figueroa High School     2949
     Huang High School        2917
     Ford High School         2739
     Wilson High School       2283
     Cabrera High School      1858
     Wright High School       1800
     Shelton High School      1761
     Thomas High School       1635
     Griffin High School      1468
     Pena High School          962
     Holden High School        427
     Name: School, dtype: int64, 82932329558, Student ID       0.749809
     Name             0.749809
     Gender           0.749809
     Grade            0.749809
     School           0.749809
     Reading Score    0.749809
     Math Score       0.749809
     Type             0.749809
     Size             0.749809
     Budget           0.749809
     dtype: float64, Student ID       0.858055
     Name             0.858055
     Gender           0.858055
     Grade            0.858055
     School           0.858055
     Reading Score    0.858055
     Math Score       0.858055
     Type             0.858055
     Size             0.858055
     Budget           0.858055
     dtype: float64, Student ID       0.803932
     Name             0.803932
     Gender           0.803932
     Grade            0.803932
     School           0.803932
     Reading Score    0.803932
     Math Score       0.803932
     Type             0.803932
     Size             0.803932
     Budget           0.803932
     dtype: float64)


