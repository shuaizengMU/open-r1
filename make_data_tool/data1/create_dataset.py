import pandas as pd
import glob
from sklearn.model_selection import train_test_split

def load_and_merge_excels(files_dir):
    # Get all Excel files in make_data_tool directory
    excel_files = glob.glob(files_dir)
    
    # Read each file into a DataFrame and store in list
    dfs = []
    for file in excel_files:
        df = pd.read_excel(file)
        dfs.append(df)
    
    # Merge all DataFrames
    merged_df = pd.concat(dfs, ignore_index=True)
    
    cols = ["题目", "选项A", "选项B", "选项C", "选项D", "选项E", "参考答案"]
    merged_df = merged_df[cols]

    for col in cols:
        merged_df[col] = merged_df[col].str.replace('.', '', n=1, regex=False)

    return merged_df


def convert_to_openr1_format(data_df):
    results = []
    for _, row in data_df.iterrows():
        
        if len(row["参考答案"]) > 1:
            continue

        question_text = row["题目"]
        options = [
            "A." + row.get("选项A", ""),
            "B." + row.get("选项B", ""),
            "C." + row.get("选项C", ""),
            "D." + row.get("选项D", ""),
            "E." + row.get("选项E", "")
        ]

        full_question = question_text.strip() + "\n\n" + "\n".join(opt for opt in options if opt)

        ans = row["参考答案"]
        item = {
            "problem": full_question,
            "solution": f"${ans}$",
            "answer": ans,
            "problem_type": "single_choice"
        }
        results.append(item)

    return pd.DataFrame(results)


if __name__ == '__main__':
    data_df = load_and_merge_excels(files_dir='make_data_tool/*.xlsx')
    
    data_df = data_df.dropna()

    dataset_df = convert_to_openr1_format(data_df)
    train_df, valid_df = train_test_split(dataset_df, test_size=0.2, random_state=42)

    
    output_dir = "make_data_tool/train.csv"
    train_df.to_csv(output_dir, index=False)

    output_dir = "make_data_tool/val.csv"
    valid_df.to_csv(output_dir, index=False)